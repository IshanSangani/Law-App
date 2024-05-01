const ToDoModel = require("../models/todo.model");
const { v4: uuidv4 } = require('uuid');
const ToDoService = require('../services/todo.service'); // Adjust the path if needed
exports.createHearingEvent = async (req, res, next) => {
    try {
        // Extract case filing data from the request body
        const { caseType, petitionerAge, respondentAge } = req.body;
        
        // Generate a unique case ID
        const caseId = uuidv4();

        // Determine priority based on case type, petitioner age, and respondent age
        let priority;
        switch (caseType) {
            case 'Divorce':
                if (petitionerAge > 60 || respondentAge > 60) {
                    priority = 'High';
                } else {
                    priority = 'Medium';
                }
                break;
            case 'Property Dispute':
                if (petitionerAge > 60 || respondentAge > 60) {
                    priority = 'High';
                } else if (petitionerAge < 18 || respondentAge < 18) {
                    priority = 'Low';
                } else {
                    priority = 'Medium';
                }
                break;
            case 'Criminal Case':
                if (petitionerAge < 18 || respondentAge < 18) {
                    priority = 'High';
                } else {
                    priority = 'Medium';
                }
                break;
            case 'Civil Dispute':
                if (petitionerAge > 60 || respondentAge > 60) {
                    priority = 'Medium';
                } else {
                    priority = 'Low';
                }
                break;
            case 'Child Custody':
                if (petitionerAge < 18 || respondentAge < 18) {
                    priority = 'High';
                } else if (petitionerAge > 60 || respondentAge > 60) {
                    priority = 'Low';
                } else {
                    priority = 'Medium';
                }
                break;
            case 'Bankruptcy':
                priority = 'Medium';
                break;
            case 'Employment Dispute':
                priority = 'Medium';
                break;
            case 'Personal Injury':
                if (petitionerAge > 60 || respondentAge > 60) {
                    priority = 'High';
                } else {
                    priority = 'Medium';
                }
                break;
            default:
                priority = 'Low';
        }

        // Determine hearing date based on case type
        let hearingDate = await getNextAvailableHearingDate(caseType);
        
        // Call the ToDoService method to create a new hearing event
        let todoData = await ToDoService.createHearingEvent(req.body, caseId, priority, hearingDate);
        res.json({ status: true, success: todoData });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}

// Function to get the next available hearing date
async function getNextAvailableHearingDate(caseType) {
    let currentDate = new Date();
    let hearingDate;
    
    switch (caseType) {
        case 'Divorce':
            hearingDate = await findNextAvailableDate(currentDate, 30);
            break;
        case 'Property Dispute':
            hearingDate = await findNextAvailableDate(currentDate, 60);
            break;
        case 'Criminal Case':
            hearingDate = await findNextAvailableDate(currentDate, 15);
            break;
        case 'Civil Dispute':
            hearingDate = await findNextAvailableDate(currentDate, 45);
            break;
        case 'Child Custody':
            hearingDate = await findNextAvailableDate(currentDate, 90);
            break;
        case 'Bankruptcy':
            hearingDate = await findNextAvailableDate(currentDate, 30);
            break;
        case 'Employment Dispute':
            hearingDate = await findNextAvailableDate(currentDate, 45);
            break;
        case 'Personal Injury':
            hearingDate = await findNextAvailableDate(currentDate, 60);
            break;
        default:
            hearingDate = await findNextAvailableDate(currentDate, 90);
            break;
    }
    
    return hearingDate;
}

// Function to find the next available date without overlapping
async function findNextAvailableDate(currentDate, daysToAdd) {
    let nextDate = new Date(currentDate);
    nextDate.setDate(nextDate.getDate() + daysToAdd);
    
    // Check if there are any existing hearings on the calculated date
    let existingHearing = await ToDoModel.findOne({ hearingDate: nextDate });
    
    // If there is an existing hearing, recursively find the next available date
    if (existingHearing) {
        return findNextAvailableDate(nextDate, 1); // Try the next day
    } else {
        return nextDate; // Return the next available date
    }
}

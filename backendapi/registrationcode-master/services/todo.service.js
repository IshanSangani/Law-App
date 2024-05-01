const ToDoModel = require("../models/todo.model");


class ToDoService {
  static async createHearingEvent(caseFilingData, caseId, priority, hearingDate) {
    const { caseType, petitionerName, petitionerAge, respondentName, respondentAge, petitionerLawyerName, petitionerLawyerEmail, petitioneremail } = caseFilingData;
    const createEvent = new ToDoModel({ 
        caseType, 
        petitionerName, 
        petitionerAge, 
        respondentName, 
        respondentAge, 
        petitionerLawyerName, 
        petitionerLawyerEmail, 
        petitioneremail, 
        caseId,
        priority,  // Include priority field
        hearingDate // Include hearing date field
    });
    return await createEvent.save();
  }
  
  static async getSortedUserHearingEventsWithType(userId, caseType) {
    let hearingEvents = await ToDoModel.find({ userId, caseType });
    // Sorting logic here
    return hearingEvents;
  }

  static async getCaseList() {
    try {
        // Fetch all case lists from MongoDB
        const caseLists = await ToDoModel.find({}, { petitionerName: 1, priority: 1, caseType: 1, hearingDate: 1 });
        return caseLists;
    } catch (error) {
        console.error("Error fetching case list:", error);
        throw new Error("Error fetching case list");
    }
}


  static async getCaseDetailsByEmail(email) {
    try {
        const caseDetails = await ToDoModel.findOne({ petitioneremail: email });
        return caseDetails;
    } catch (error) {
        console.error("Error fetching case details:", error);
        throw new Error("Error fetching case details");
    }
  }
}

module.exports = ToDoService;

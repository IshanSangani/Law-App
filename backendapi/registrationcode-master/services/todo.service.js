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

  static async deleteHearingEvent(id) {
    const deleted = await ToDoModel.findByIdAndDelete(id);
    return deleted;
  }
}

module.exports = ToDoService;

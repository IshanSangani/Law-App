const mongoose = require('mongoose');
const { Schema } = mongoose;

const toDoSchema = new Schema({
    caseType: {
        type: String,
        required: true
    },
    petitionerName: {
        type: String,
        required: true
    },
    petitionerAge: {
        type: Number,
        required: true
    },
    respondentName: {
        type: String,
        required: true
    },
    respondentAge: {
        type: Number,
        required: true
    },
    petitionerLawyerName: {
        type: String,
        required: true
    },
    petitionerLawyerEmail: {
        type: String,
        required: true
    },
    petitioneremail: { // Renamed petitioneremail to petitionerEmail
        type: String,
        required: true
    },
    priority: {
        type: String,
        default: null // Default value for priority
    },
    hearingDate: {
        type: Date,
        default: null // Default value for hearing date
    }
}, { timestamps: true });

const ToDoModel = mongoose.model('CaseInfo', toDoSchema);
module.exports = ToDoModel;

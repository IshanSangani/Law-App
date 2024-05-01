const router = require("express").Router();
const ToDoController = require('../controller/todo.controller');

// Route to create a new case hearing
router.post("/createHearingEvent", ToDoController.createHearingEvent);
router.post('/case-details', ToDoController.getCaseDetails);
router.post('/caselist',ToDoController.getCaseList);


module.exports = router;

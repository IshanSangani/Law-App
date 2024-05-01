const router = require("express").Router();
const ToDoController = require('../controller/todo.controller');

// Route to create a new case hearing
router.post("/createHearingEvent", ToDoController.createHearingEvent);



module.exports = router;

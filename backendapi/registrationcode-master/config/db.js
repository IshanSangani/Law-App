const mongoose = require('mongoose');
// mongoose.set('debug', true);


const connection = mongoose.createConnection(`mongodb+srv://ishansangani:Ishan123@cluster0.naowgnd.mongodb.net/lawappusers`).on('open',()=>{console.log("MongoDB Connected");}).on('error',()=>{
    console.log("MongoDB Connection error");
});

module.exports = connection;
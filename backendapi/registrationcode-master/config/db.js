const mongoose = require('mongoose');

mongoose.connect('mongodb+srv://ishansangani:Ishan123@cluster0.naowgnd.mongodb.net/lawappusers', {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    // Add more options as needed
})
.then(() => console.log('MongoDB Connected'))
.catch(err => console.log('MongoDB Connection Error: ', err));

module.exports = mongoose.connection;

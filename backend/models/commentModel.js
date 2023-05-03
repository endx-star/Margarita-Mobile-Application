const mongoose = require("mongoose");
const CommentSchema = new mongoose.Schema({
  user: { type: mongoose.Schema.Types.ObjectId, ref: "Userinformation"},
  username:{type:String},
  userimg:{type:String},
  description: { type: String, max: 500 },
},

{ timestamps: true });

module.exports = mongoose.model("Comment", CommentSchema);

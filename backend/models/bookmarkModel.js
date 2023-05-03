const mongoose = require("mongoose");

const bookmarkSchema = new mongoose.Schema(
  {
    user:{ type: mongoose.Schema.Types.ObjectId, ref: "Userinformation"},
 
    post: { type: mongoose.Schema.Types.ObjectId, ref: "Article"},
    //latlng: {type:Map,ref: "latlng"},
  },
  { timestamps: true }
);

module.exports = mongoose.model("bookmark", bookmarkSchema);

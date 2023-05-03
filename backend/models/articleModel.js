const mongoose = require("mongoose");

const articleSchema = new mongoose.Schema(
  {
    user: { type: mongoose.Schema.Types.ObjectId, ref: "Userinformation" },
    description: { type: String, max: 500 },
    imgurl: { type: String },
    likes: [{ type: mongoose.Schema.Types.ObjectId, ref: "Userinformation" }],
    comment: [{ type: mongoose.Schema.Types.ObjectId, ref: "Comment" }],
    lat: { type: String },
    lng: { type: String },
    cat: { type: String },
    bookmarks: [{ type: mongoose.Schema.Types.ObjectId, ref: "bookmark" }],
    //latlng: {type:Map,ref: "latlng"},
  },
  { timestamps: true }
);

module.exports = mongoose.model("Article", articleSchema);

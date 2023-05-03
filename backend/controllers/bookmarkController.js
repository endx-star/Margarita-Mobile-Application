const BookMark = require("../models/BookMarkModel");
const Article = require("../models/articleModel");

const addBookMark = async (req, res, next) => {
  /// req.body.user = req.user._id;
  console.log("req.body is ", req.body);

  const newBookMark = new BookMark(req.body);
  try {
    await newBookMark
      .save()
      .then(
         (LocProvider)=> {
          console.log("article body  is ", LocProvider._id);
           Article.findOneAndUpdate(
            { _id: req.body.post },
            { $push: { bookmarks: LocProvider._id } }
          );
          console.log("BookMark has been Added ", LocProvider);
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json(LocProvider);
        },
        (err) => next(err)
      )
      .catch((err) => next(err));
    // res.status(200).json({
    //   status: "success",
    //   message: "BookMark has been created",
    // });
  } catch (e) {
    res.status(500).json({
      status: "failure",
      message: e.message,
    });
  }
};
// const updateBookMark = async (req, res) => {
//   try {
//     const bM = await BookMark.findById(req.params.id);
//     //if (req.user._id === BookMark.user.toString()) {
//     await bM.updateOne({ $set: req.body });
//     res.status(200).send({
//       status: "success",
//       message: "BookMark has been updated",
//     });
//     // } else {
//     //   res.status(401).send({
//     //     status: "failure",
//     //     message: "you are not authorized",
//     //   });
//     // }
//   } catch (e) {
//     res.status(500).send({
//       status: "failure",
//       message: e.message,
//     });
//   }
// };
const deleteBookMark = async (req, res) => {
  try {
  //  const bM = await BookMark.findById(req.params.id);
    // if (req.user._id === BookMark.user.toString() || req.user.role === "admin") {
    //   await Comment.deleteMany({ user: req.user._id });
    await BookMark.findByIdAndDelete(req.params.id);
    res.status(200).json({
      status: "success",
      message: "BookMark has been deleted successfully",
    });
    // } else {
    //   res.status(401).send({
    //     status: "failure",
    //     message: "you are not authorized",
    //   });
    // }
  } catch (e) {
    res.status(500).json({
      status: "failure",
      message: e.message,
    });
  }
};



const getBookMarksbyUserID = async (req, res) => {
  try {
   // const user = await User.findOne({ _id: req.params.id });
    const BookMarks = await BookMark.find({ user: req.params.id }).populate(
      "user",
      "username image"
    ).populate(
      "post",
  
    );
    res.status(200).json(BookMarks);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};



module.exports = {
    addBookMark,
 // updateBookMark,
  deleteBookMark,
  getBookMarksbyUserID
};

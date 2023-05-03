var express = require("express");
var router = express.Router();
var Booking = require("../models/bookmarkModel");
const Article = require("../models/articleModel");

/* GET Operations */
router.get("/bookmarks", function (req, res, next) {
  res.send("respond with a bookmarkModel resource");
});
router.post("/addBookMark", async function (req, res, next) {
  console.log(req.body);

  const article = await Article.findById(req.body.post);
  if (!article.bookmarks.includes(req.body.user)) {
  Booking.create(req.body)
    .then(
      async (bookings) => {
        const article = await Article.findById(req.body.post);
        if (!article.bookmarks.includes(req.body.user)) {
          await article.updateOne({ $push: { bookmarks: req.body.user } });
          console.log("Article has been bookmarked");
          // res.status(200).send({
          //   status: "success",
          //   message: "the article has been liked",
          // });
        } else {
          // await article.updateOne({ $pull: { likes: req.params.userid } });
          // res.status(200).send({
          //   status: "success",
          //   message: "the article has been disliked",
          // });
        }
        //  await Article.findOneAndUpdate(
        //     { _id: req.body.post },
        //     { $push: { bookmarks:req.body.user } }
        //   );
        console.log("bookmarkModel has been Added ", bookings);
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(bookings);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
}});
router.get("/getBookmark/:userid", function (req, res, next) {
  Booking.find({ user: req.params.userid })
    .populate("user", "username image")
    .populate("post")
    .populate("bookmarks")
    .exec(function (error, results) {
      if (error) {
        return next(error);
      }
      // Respond with valid data
      res.json(results);
    });
});

router.delete(
  "/deletebookMark/:userid/:postid",
  async function (req, res, next) {
    await Booking.deleteOne(
      { user: req.params.userid, post: req.params.postid },

      async function  (error, results)  {
        if (error) {
          return next(error);
        }

        const article = await Article.findById(req.params.postid);

        article.updateOne({ $pull: { bookmarks: req.params.userid } }).then((value)=>{

console.log(value)

        });
        // Respond with valid data
        res.json(results);
      }
    );
  }
);

module.exports = router;

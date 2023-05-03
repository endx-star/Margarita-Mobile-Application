const Article = require("../models/articleModel");
const User = require("../models/user.model");
const Comment = require("../models/commentModel");

const createArticle = async (req, res, next) => {
  /// req.body.user = req.user._id;
  console.log("req.body is ", req.body);

  const newArticle = new Article(req.body);
  try {
    await newArticle
      .save()
      .then(
        (LocProvider) => {
          console.log("Article has been Added ", LocProvider);
          res.statusCode = 200;
          res.setHeader("Content-Type", "application/json");
          res.json(LocProvider);
        },
        (err) => next(err)
      )
      .catch((err) => next(err));
    // res.status(200).json({
    //   status: "success",
    //   message: "article has been created",
    // });
  } catch (e) {
    res.status(500).json({
      status: "failure",
      message: e.message,
    });
  }
};
const updateArticle = async (req, res) => {
  try {
    const article = await Article.findById(req.params.id);
    //if (req.user._id === article.user.toString()) {
    await article.updateOne({ $set: req.body });
    res.status(200).send({
      status: "success",
      message: "article has been updated",
    });
    // } else {
    //   res.status(401).send({
    //     status: "failure",
    //     message: "you are not authorized",
    //   });
    // }
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};
const deleteArticle = async (req, res) => {
  try {
    const article = await Article.findById(req.params.id);
    // if (req.user._id === article.user.toString() || req.user.role === "admin") {
    //   await Comment.deleteMany({ user: req.user._id });
    await Article.findByIdAndDelete(req.params.id);
    res.status(200).json({
      status: "success",
      message: "article has been deleted",
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
const getTimeline = async (req, res) => {
  try {
    const userid = req.user._id;
    const page = parseInt(req.query.page) - 1 || 0;
    const limit = parseInt(req.query.limit) || 1;
    const user = await User.findById(userid).select("following");
    const myArticles = await Article.find({ user: userid })
      .skip(page * limit)
      .limit(limit)
      .sort({ createdAt: "desc" })
      .populate("user", "username image");
    const followingsArticles = await Promise.all(
      user.followings.map((followingId) => {
        return Article.find({
          user: followingId,
          createdAt: {
            $gte: new Date(new Date().getTime() - 86400000).toISOString(),
          },
        })
          .skip(page * limit)
          .limit(limit)
          .sort({ createdAt: "desc" })
          .populate("user", "username image");
      })
    );
    arr = myArticles.concat(...followingsArticles);
    res.status(200).send({
      status: "success",
      Articles: arr,
      limit: arr.length,
    });
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};
const getArticlesUser = async (req, res) => {
  try {
    const user = await User.findOne({ username: req.params.username });
    const articles = await Article.find({ user: user._id });
    res.status(200).json(articles);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};

const getArticlesbyUserID = async (req, res) => {
  try {
    const user = await User.findOne({ _id: req.params.id });
    const articles = await Article.find({ user: req.params.id }).populate(
      "user",
      "username image"
    ).populate(
      "comment",
  
    ).populate(
      "likes",
  
    ).populate(
      "bookmarks",
  
    );
    res.status(200).json(articles);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};

const getarticlesbyCategory = async (req, res) => {
  try {
  //  const user = await User.findOne({ _id: req.params.id });
    const articles = await Article.find({ cat: req.params.cat }).populate(
      "user",
      "username image"
    ).populate(
      "comment",
  
    ).populate(
      "likes",
  
    );
    res.status(200).json(articles);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};
const getArticle = async (req, res) => {
  try {
    const article = await Article.findOne({ _id: req.params.id }).populate(
      "likes"
    ).populate(
      "comment"
    );
    res.status(200).json(article);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};
const likeUnlike = async (req, res) => {
  try {
    const article = await Article.findById(req.params.postid);
    if (!article.likes.includes(req.params.userid)) {
      await article.updateOne({ $push: { likes: req.params.userid } });
      res.status(200).send({
        status: "success",
        message: "the article has been liked",
      });
    } else {
      await article.updateOne({ $pull: { likes: req.params.userid } });
      res.status(200).send({
        status: "success",
        message: "the article has been disliked",
      });
    }
  } catch (error) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};

const getallArticles = async (req, res) => {
  try {
    const articles = await Article.find({});
    res.status(200).json(articles);
  } catch (e) {
    res.status(500).send({
      status: "failure",
      message: e.message,
    });
  }
};
module.exports = {
  createArticle,
  updateArticle,
  deleteArticle,
  getTimeline,
  getArticlesUser,
  getArticle,

  likeUnlike,
  getallArticles,
  getArticlesbyUserID,
  getarticlesbyCategory
};

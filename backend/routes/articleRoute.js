const router = require("express").Router();
const articleController = require("../controllers/articleController");
//const authController = require("../controllers/authController");

router.post("/createPost", articleController.createArticle);
router.post("/updatePost/:id", articleController.updateArticle);
router.delete("/deletePost/:id", articleController.deleteArticle);
router.get("/timeline", articleController.getTimeline);
router.get("/u/:username", articleController.getArticlesUser);
router.get("/getArticle/:id", articleController.getArticle);
router.get("/likedislike/:postid/:userid", articleController.likeUnlike);
router.get("/articles", articleController.getallArticles);
router.get("/getarticlesbyUserID/:id", articleController.getArticlesbyUserID);
//router.get("/getarticlesbycat/:cat", articleController.getArticlesbyUserID);


router.get(
  "/getarticlesbyCategory/:cat",
  articleController.getarticlesbyCategory
);

module.exports = router;

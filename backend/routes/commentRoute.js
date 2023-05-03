const router = require("express").Router();
const commentController = require("../controllers/commentController");

router.post("/addComment/:id",commentController.addComment);
router.get("/getCommentbyId/:ArticleId", commentController.getbyPostId);

module.exports = router;

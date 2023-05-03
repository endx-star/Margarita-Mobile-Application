var express = require("express");
var router = express.Router();
var FAQProvider = require("../models/faq");

/* GET Operations */
router.get("/", function (req, res, next) {
  res.send("respond with a contactus resource");
});

///post api for posting complains
router.post("/addquestion", function (req, res, next) {
  console.log(req.body);
  FAQProvider.create({
    userid: req.body.userid,
    username: req.body.username,
    message: req.body.message,
    date: req.body.date,
    useremail: req.body.useremail,
  })
    .then(
      (FAQProvider) => {
        console.log("complaint has been Added ", FAQProvider);
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(FAQProvider);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
});

/// get api for getting all complains
router.get("/getallquestion", function (req, res, next) {
    FAQProvider.find({}, function (error, results) {
    if (error) {
      return next(error);
    }
    res.json(results);
  });
});


router.post("/giveresponse/:id", function (req, res) {
    FAQProvider.findByIdAndUpdate(
      { _id: req.params.id },
      { $set: req.body },
      { new: true },
  
      function (err, response) {
        if (err)
          res.json({
            message: "Error in giveresponse" + req.params.id,
          });
        res.json(response);
      }
    );
  });

///get all the list of articles

module.exports = router;

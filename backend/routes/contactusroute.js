var express = require("express");
var router = express.Router();
var ContactusProvider = require("../models/contactus");

/* GET Operations */
router.get("/", function (req, res, next) {
  res.send("respond with a contactus resource");
});

///post api for posting complains
router.post("/addcomplaint", function (req, res, next) {
  console.log(req.body);
  ContactusProvider.create({
    userid: req.body.userid,
    username: req.body.username,
    message: req.body.message,
    date: req.body.date,
    useremail: req.body.useremail,
  })
    .then(
      (ContactusProvider) => {
        console.log("complaint has been Added ", ContactusProvider);
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(ContactusProvider);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
});

/// get api for getting all complains
router.get("/getallcomplaints", function (req, res, next) {
  ContactusProvider.find({}, function (error, results) {
    if (error) {
      return next(error);
    }
    res.json(results);
  });
});

///get all the list of articles

module.exports = router;

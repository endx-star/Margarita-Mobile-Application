var express = require("express");
var router = express.Router();
var LocProvider = require("../models/locationmodel");

/* GET Operations */
router.get("/", function (req, res, next) {
  res.send("respond with a contactus resource");
});

///post api for posting complains
router.post("/addlocationhistory", function (req, res, next) {
  console.log(req.body);
  LocProvider.create({
    userid: req.body.userid,
    address: req.body.address,
    time: req.body.time,
    date: req.body.date,
  })
    .then(
      (LocProvider) => {
        console.log("location has been Added ", LocProvider);
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(LocProvider);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
});

/// get api for getting all complains
router.get("/getlocbydate/:userid/:date", function (req, res, next) {
  LocProvider.find(
    {
      userid: req.params.userid,
      date: req.params.date,
    },
    function (error, results) {
      if (error) {
        return next(error);
      }
      res.json(results);
    }
  );
});

///get all the list of articles

module.exports = router;

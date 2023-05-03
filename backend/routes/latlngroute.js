var express = require("express");
var router = express.Router();
var LatProvider = require("../models/latlngmodel");

/* GET Operations */
router.get("/", function (req, res, next) {
  res.send("respond with a contactus resource");
});

///post api for posting complains
router.get("/addlatlng/:lat/:lng", function (req, res, next) {
  console.log(req.body);
  LatProvider.create({
    lat: req.params.lat,
    lng: req.params.lng,
  })
    .then(
      (LatProvider) => {
        console.log("latlng has been Added ", LatProvider);
        res.statusCode = 200;
        res.setHeader("Content-Type", "application/json");
        res.json(LatProvider);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
});
router.post("/updatelocation", function (req, res) {
  LatProvider.updateOne(
    {},
    { $set: req.body },
    { new: true },

    function (err, response) {
      if (err)
        res.json({
          message: "Error in editservice with id " + req.params.id,
        });
      res.json(response);
    }
  );
});
/// get api for getting all complains
router.get("/getlatlng", function (req, res, next) {
  LatProvider.find({}, function (error, results) {
    if (error) {
      return next(error);
    }
    res.json(results);
  });
});

///get all the list of articles

module.exports = router;

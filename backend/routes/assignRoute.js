var express = require("express");
const { ObjectId } = require("mongodb");
var router = express.Router();
const AssignTo = require("../models/assignModel");

/* GET Operations */
router.get("/", function (req, res, next) {
  res.send("respond with a habit source");
});

router.post("/addAssignTo", function (req, res, next) {
  // const str = req.body.specificweek;
  // var arr = str.split(',');
  console.log(req.body);

  AssignTo.create({
    assignto: req.body.assignto,
  
    habitid: req.body.habitid,

  })
    .then(
      (response) => {
        console.log("assignTo has been Added ", response);
        res.statusCode = 200;
        //res.setHeader("Content-Type", "application/json");
        res.json(response);
      },
      (err) => next(err)
    )
    .catch((err) => next(err));
});


router.get("/getAllAssign/:habitid", function (req, res, next) {
    AssignTo.find({habitid:req.params.habitid}, function (error, results) {
      if (error) {
        return next(error);
      }
      // Respond with valid data
      res.json(results);
    });
  });

router.post("/updateAssignbyId/:id", function (req, res) {
    AssignTo.findOneAndUpdate(
    {
      _id: req.params.id,
    },
    {
      $set: {
        assignto: req.body.assignto,
      },
    },
    { new: true },

    function (err, response) {
      if (err) {
        console.log(err);
        res.json({
          message: "Error in updatestatus with id " + req.params.id,
        });
      }

      res.json(response);
      console.log(response);
    }
  );
});

router.post("/edithabitbyid/:id", function (req, res) {
  Habit.findByIdAndUpdate(
    { _id: req.params.id },
    { $set: req.body },
    { new: true },

    function (err, response) {
      if (err)
        res.json({
          message: "Error in edit habit with id " + err,
        });
      res.json(response);
    }
  );
});

router.delete("/deletehabitbyid/:id", function (req, res) {
  Habit.deleteOne(
    { _id: req.params.id },

    function (err, response) {
      if (err)
        res.json({
          message: "Error in delete Kid with id " + req.params.id,
        });
      res.json(response);
    }
  );
});

module.exports = router;

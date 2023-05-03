const express = require('express')
const User = require('../models/user.model')
const router = express.Router()
var bcrypt = require('bcryptjs')
// var http = require('http');

// router.http("/", function (req, res, next) {

//   res.writeHead(200, { 'Content-Type':'text/html'});

//   res.end("<form method=\"post\" name=\"echoForm\" action=\"https:\/\/sadadqa.com\/\/napsapi\/pay.php\"onload=\" return this.sadadSubmit();\"><input type=\"hidden\" name=\"Action\" value=\"0\" \/><input type=\"hidden\" name=\"Amount\" value=\"300\" \/><input type=\"hidden\" name=\"BankID\" value=\"QPAYPG01\" \/><input type=\"hidden\" name=\"CurrencyCode\" value=\"634\" \/><input type=\"hidden\" name=\"ExtraFields_f14\" value=\"https:\/\/sadadqa.com\/napsapi\/response.php?sid=aFiGSSOtjD2NebYTMRc8qQHaum3slfnO52FJwEQn63e4bbe640042\" \/><input type=\"hidden\" name=\"Lang\" value=\"EN\" \/><input type=\"hidden\" name=\"MerchantID\" value=\"1296004606\" \/><input type=\"hidden\" name=\"MerchantModuleSessionID\" value=\"aFiGSSOtjD2NebYTMRc8qQHaum3slfnO52FJwEQn63e4bbe640042\" \/><input type=\"hidden\" name=\"NationalID\" value=\"UAE\" \/><input type=\"hidden\" name=\"PUN\" value=\"SD2927599065068\" \/><input type=\"hidden\" name=\"PaymentDescription\" value=\"Paying QAR 3.00\" \/><input type=\"hidden\" name=\"Quantity\" value=\"1\" \/><input type=\"hidden\" name=\"TransactionRequestDate\" value=\"SD2927599065068\" \/><input type=\"hidden\" name=\"SecureHash\" value=\"18e44aa7c45db473aed2f093fdd21fd6efb9e23a12b1630c591c0940fd963000\" \/><input type=\"hidden\" name=\"ExtraFields_f3\" value=\"\" \/><input type=\"hidden\" name=\"qPayRedUrl\" value=\"https:\/\/pgtest3.qcb.gov.qa\/QPayOnePC\/PaymentPayServlet\" \/><input type=\"hidden\" name=\"directdebitpay\" value=\"1\" \/><\/form>");
// });

router.post('/signup', (req, res) => {
  User.findOne({ email: req.body.email }, (err, user) => {
    if (err) {
      console.log(err)
      res.json(err)
    } else {
      if (user == null) {
        const user = User({
          email: req.body.email,
          password: req.body.password,
          usertype: req.body.usertype,
        })
        user.save().then((err) => {
          if (err) {
            console.log(err)
            res.json(err)
          } else {
            console.log(user)
            res.json(user)
          }
        })
      } else {
        res.json('email is not avilable')
      }
    }
  })
})

router.post('/signupwithbycript', async (req, res) => {
  var newUser = new User({
    email: req.body.email,
    password: req.body.password,
    usertype: req.body.usertype,
  })

  await User.findOne({ email: newUser.email })
    .then(async (profile) => {
      var saltRouds = 10

      if (!profile) {
        bcrypt.hash(newUser.password, saltRouds, async (err, hash) => {
          if (err) {
            console.log('Error is hashing', err.message)
          } else {
            newUser.password = hash
            await newUser
              .save()
              .then(() => {
                res.status(200).json(newUser)
              })
              .catch((err) => {
                console.log('Error is ', err.message)
              })
          }
        })
      } else {
        res.json('email is not avilable')
      }
    })
    .catch((err) => {
      console.log('Error is', err.message)
    })
})
router.post('/signupwithbycript2', async (req, res) => {
  var newUser = new User({
    email: req.body.email,
    password: req.body.password,
    usertype: req.body.usertype,
  })

  await User.findOne({ email: newUser.email })
    .then(async (profile) => {
      //   var saltRouds = 10;

      if (!profile) {
        // bcrypt.hash(newUser.password, saltRouds, async (err, hash) => {
        //   if (err) {
        //     console.log("Error is hashing", err.message);
        //   } else {

        //     newUser.password = hash;
        await newUser
          .save()
          .then(() => {
            res.status(200).json(newUser)
          })
          .catch((err) => {
            console.log('Error is ', err.message)
          })
        //   }
        // });
      } else {
        res.json('email is not avilable')
      }
    })
    .catch((err) => {
      console.log('Error is', err.message)
    })
})
router.post('/login2', async (req, res) => {
  var newUser = {}
  newUser.email = req.body.email
  newUser.password = req.body.password

  await User.findOne({ email: newUser.email })
    .then((profile) => {
      if (!profile) {
        res.json('User not exist')
      } else {
        bcrypt.compare(
          newUser.password,
          profile.password,
          async (err, result) => {
            if (err) {
              console.log('Error is', err.message)
            } else if (result == true) {
              res.json(profile)
            } else {
              res.json('Unauthorized')
            }
          },
        )
      }
    })
    .catch((err) => {
      console.log('Error is ', err.message)
    })
})
router.post('/login3', async (req, res) => {
  var newUser = {}
  newUser.email = req.body.email
  newUser.password = req.body.password

  await User.findOne({ email: newUser.email })
    .then((profile) => {
      if (!profile) {
        res.json('User not exist')
      } else {
        if (profile.password == newUser.password) {
          res.json(profile)
        } else {
          res.json('Unauthorized')
        }
        // bcrypt.compare(
        //   newUser.password,
        //   profile.password,
        //   async (err, result) => {
        //     if (err) {
        //       console.log("Error is", err.message);
        //     } else if (result == true) {
        //       res.json(profile);
        //     } else {
        //       res.json("Unauthorized");
        //     }
        //   }
        // );
      }
    })
    .catch((err) => {
      console.log('Error is ', err.message)
    })
})
router.post('/forgotpasswordss', async (req, res) => {
  var newUser = {}
  newUser.email = req.body.email
  newUser.password = req.body.password

  await User.findOne({ email: newUser.email })
    .then((profile) => {
      if (!profile) {
        res.json('User not exist')
      } else {
        res.json(profile)
      }
    })
    .catch((err) => {
      console.log('Error is ', err.message)
    })
})

router.post('/register', (req, res) => {
  User.findOne({ email: req.body.email }).then((user) => {
    if (user.email == req.body.email) {
      return res.status(400).json(user)
    } else {
      const newUser = new User({
        email: req.body.email,
        password: req.body.password,
        usertype: req.body.usertype,
      })

      bcrypt.genSalt(10, (err, salt) => {
        bcrypt.hash(newUser.password, salt, (err, hash) => {
          console.log(333)
          if (err) throw err
          newUser.password = hash
          newUser
            .save()
            .then((user) => res.json(user))
            .catch((err) => console.log(err))
        })
      })
    }
  })
})

router.post('/signup', async (req, res) => {
  res.setHeader('Content-Type', 'text/html')
  await User.findOne({ email: 'john@yopmail.com' }).then((user) => {
    if (user.email == req.body.email) {
      return res.status(400).json(user)
    } else {
      const user = User({
        email: req.body.email,
        password: req.body.password,
        usertype: req.body.usertype,
      })
      user.save().then((err) => {
        if (err) {
          console.log(err)
          res.json(err)
        } else {
          console.log(user)
          res.json(user)
        }
      })
    }
  })
})

router.post('/signin', (req, res) => {
  User.findOne(
    { email: req.body.email, password: req.body.password },
    (err, user) => {
      if (err) {
        console.log(err)
        res.json(err)
      } else {
        res.json(user)
      }
    },
  )
})

router.get('/getallusers', (req, res) => {
  User.find({ usertype: 'user' }, (err, user) => {
    if (err) {
      console.log(err)
      res.json(err)
    } else {
      res.json(user)
    }
  })
})

router.get('/getallmerchants', (req, res) => {
  User.find({ usertype: 'serviceprovider' }, (err, user) => {
    if (err) {
      console.log(err)
      res.json(err)
    } else {
      res.json(user)
    }
  })
})
router.get('/getallvendors', (req, res) => {
  User.find({ usertype: 'vendor' }, (err, user) => {
    if (err) {
      console.log(err)
      res.json(err)
    } else {
      res.json(user)
    }
  })
})
router.get('/getalltrainers', (req, res) => {
  User.find({ usertype: 'Trainer' }, (err, user) => {
    if (err) {
      console.log(err)
      res.json(err)
    } else {
      res.json(user)
    }
  })
})

router.post('/updateuserbyid/:id', function (req, res) {
  var saltRouds = 10

  bcrypt.hash(req.body.password, saltRouds, async (err, hash) => {
    if (err) {
      console.log('Error is hashing', err.message)
    } else {
      req.body.password = hash
    }
  })

  User.findByIdAndUpdate(
    { _id: req.params.id },
    { $set: req.body },
    { new: true },

    function (err, response) {
      if (err)
        res.json({
          message: 'Error in editservice with id ' + req.params.id,
        })
      res.json(response)
    },
  )
})


//search user by its email
router.get('/users/:email', async (req, res) => {
  try {
    const user = await User.findOne({ email: req.params.email })
    if (!user) {
      return res.status(404).json({ message: 'User not found' })
    }
    res.json(user)
  } catch (err) {
    console.error(err)
    res.status(500).json({ message: 'Server Error' })
  }
})
module.exports = router

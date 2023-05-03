const express = require('express')
const app = express()
const port = process.env.PORT || 8080
const cors = require('cors')
const bodyParser = require('body-parser')

const mongoose = require('mongoose')
mongoose.connect(
  // 'mongodb://localhost:27017/margaritaApp',
  // 'mongodb+srv://abrarbilalmicheal:abrarbilalmicheal@cluster0.16zft.mongodb.net/petaffixdb?retryWrites=true&w=majority',
  'mongodb+srv://margaritamayhemcompany:Iqpq58k8WfbW66Zm@cluster0.3jntivp.mongodb.net/petaffixdb?retryWrites=true&w=majority',
  {
    useNewUrlParser: true,
    useUnifiedTopology: true,
    useFindAndModify: false,
    useCreateIndex: true,
  },
),
  app.use(cors())
app.use(bodyParser.urlencoded({ extended: true }))
app.use(bodyParser.json())
app.use('/', require('./routes/user.route'))
app.use('/', require('./routes/userinformation'))
app.use('/', require('./routes/bookingroute'))
app.use('/', require('./routes/contactusroute'))
app.use('/', require('./routes/locationroute'))
app.use('/', require('./routes/latlngroute'))
app.use('/', require('./routes/articleRoute'))
app.use('/', require('./routes/commentRoute'))

app.listen(port, () => {
  console.log('port running on ' + port)
})

const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
const bodyParser = require('body-parser');

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.post('/login', (req, res) => {
  const { username, password } = req.body;
  // Handle login logic here
  res.send(`Login attempted with username: ${username} and password: ${password}`);
});

app.post('/signin', (req, res) => {
  const { username, password } = req.body;
  // Handle signin logic here
  res.send(`Signin attempted with username: ${username} and password: ${password}`);
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

const express = require('express');
const app = express();
const port = 3000;
const path = require('path');
const bodyParser = require('body-parser');
const { Pool } = require('pg');

const pool = new Pool({
  user: 'locallink_user',
  host: 'localhost',
  database: 'locallink',
  password: 'locallink_password',
  port: 5433,
});

app.use(bodyParser.urlencoded({ extended: true }));

app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

app.post('/login', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await pool.query('SELECT * FROM users WHERE username = $1 AND password = $2', [username, password]);
    if (result.rows.length > 0) {
      res.send(`Login successful for username: ${username}`);
    } else {
      res.send('Invalid username or password');
    }
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

app.post('/signup', async (req, res) => {
  const { username, password } = req.body;
  try {
    const result = await pool.query('INSERT INTO users (username, password) VALUES ($1, $2) RETURNING *', [username, password]);
    res.send(`Signup successful for username: ${username}`);
  } catch (err) {
    console.error(err);
    res.status(500).send('Server error');
  }
});

app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});

import bodyParser from 'body-parser';
import express from 'express';
import cors from 'cors';
import routes from './routes';
import dotenv from 'dotenv';
import path from 'path';

const app: express.Application = express();
const port = process.env.PORT;

dotenv.config();

// const corsoptions = {
//   origin:process.env.NODE_ENV==='dev'?process.env.DEV_FRONT_LINK:process.env.PROD_FRONT_LINK,
//   optionsSuccessStatus: 200
// };

// const options = {
//   uploadDir: path.join(__dirname, 'uploads'),
//   autoClean: true
// };


// Use express-form-data middleware with the provided options
// app.use(formData.parse(options));
// app.use(formData.format());
// app.use(formData.stream());
// app.use(formData.union());

app.use(cors());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

app.use(routes);

app.listen(port, async (): Promise<void> => {
  const url = `http://localhost:${port}`;
  console.log(`Open ${url} to review the project..`);
});

export default app;

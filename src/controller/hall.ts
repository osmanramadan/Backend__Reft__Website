import path from 'path';
import { Hall } from '../model/hall';
import { hall } from '../types/hall';
import UserController from './user';
import { Request, Response } from 'express';
import fs from 'fs';

const hallobject = new Hall();
const userobject = new UserController();

export default class HallController {
  index = async (_req: Request, res: Response) => {
    try {
      const halls = await hallobject.index();
      const data = [];
      if (halls) {
        for (const value of halls) {
          const imagePath = path.join(
            __dirname,
            '../uploads/halls',
            // @ts-ignore
            value.cover_image
          );

          try {
            const imageData = await fs.promises.readFile(imagePath);
            const imgCover = { imageCoverData: imageData.toString('base64') };
            const imagesData = [];

            // @ts-ignore
            for (const img of value.images) {
              const imagePath = path.join(__dirname, '../uploads/halls', img);
              const imageData = await fs.promises.readFile(imagePath);
              imagesData.push(imageData.toString('base64'));
            }

            const imgsData = { imagesData: imagesData };

            const user = await userobject.show(value.user_id as number);
            let userData;
            if (user) {
              userData = {
                userData: {
                  id: user.id,
                  name: user.name,
                  phone: user.phone,
                  email: user.email,
                  city: user.city
                }
              };
            }

            const stars = await hallobject.getHallRate(value.id as number);

            const array_rate = { rate: stars };

            data.push({
              ...value,
              ...imgsData,
              ...imgCover,
              ...userData,
              ...array_rate
            });
          } catch (err) {
            res.json({ status: 'fail' });
            return;
          }
        }
        res.json({ status: 'success', data: data });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  adminindex = async (_req: Request, res: Response) => {
    try {
      const halls = await hallobject.adminindex();
      const data = [];

      if (halls) {
        for (const value of halls) {
          const imagePath = path.join(
            __dirname,
            '../uploads/halls',
            // @ts-ignore
            value.cover_image
          );

          try {
            const imageData = await fs.promises.readFile(imagePath);
            const imgCover = { imageCoverData: imageData.toString('base64') };
            const imagesData = [];

            // @ts-ignore
            for (const img of value.images) {
              const imagePath = path.join(__dirname, '../uploads/halls', img);
              const imageData = await fs.promises.readFile(imagePath);
              imagesData.push(imageData.toString('base64'));
            }

            const imgsData = { imagesData: imagesData };

            const user = await userobject.show(value.user_id as number);
            let userData;
            if (user) {
              userData = {
                userData: {
                  name: user.name,
                  phone: user.phone,
                  email: user.email,
                  city: user.city
                }
              };
            }
            const stars = await hallobject.getHallRate(value.id as number);

            const array_rate = { rate: stars };
            data.push({
              ...value,
              ...imgsData,
              ...imgCover,
              ...userData,
              ...array_rate
            });
          } catch (err) {
            res.json({ status: 'fail' });
            return;
          }
        }

        res.json({ status: 'success', data: data });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  userindex = async (req: Request, res: Response) => {
    try {
      const halls = await hallobject.userindex(req.params.id);
      const data = [];

      if (halls) {
        for (const value of halls) {
          const imagePath = path.join(
            __dirname,
            '../uploads/halls',
            // @ts-ignore
            value.cover_image
          );

          try {
            const imageData = await fs.promises.readFile(imagePath);
            const imgCover = { imageCoverData: imageData.toString('base64') };
            const imagesData = [];

            // @ts-ignore
            for (const img of value.images) {
              const imagePath = path.join(__dirname, '../uploads/halls', img);
              const imageData = await fs.promises.readFile(imagePath);
              imagesData.push(imageData.toString('base64'));
            }

            const imgsData = { imagesData: imagesData };

            const user = await userobject.show(value.user_id as number);
            let userData;
            if (user) {
              userData = {
                userData: {
                  name: user.name,
                  phone: user.phone,
                  email: user.email,
                  city: user.city
                }
              };
            }

            const stars = await hallobject.getHallRate(value.id as number);

            const array_rate = { rate: stars };

            data.push({
              ...value,
              ...imgsData,
              ...imgCover,
              ...userData,
              ...array_rate
            });
          } catch (err) {
            res.json({ status: 'fail' });
            return;
          }
        }

        res.json({ status: 'success', data: data });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  getvideo = async (req: Request, res: Response) => {
    const { filename } = req.params;
    const videoPath = path.join(__dirname, '../uploads/videos', filename);

    if (fs.existsSync(videoPath)) {
      const stat = fs.statSync(videoPath);
      const fileSize = stat.size;
      const range = req.headers.range;

      if (range) {
        const parts = range.replace(/bytes=/, '').split('-');
        const start = parseInt(parts[0], 10);
        const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
        const chunksize = end - start + 1;
        const file = fs.createReadStream(videoPath, { start, end });
        const head = {
          'Content-Range': `bytes ${start}-${end}/${fileSize}`,
          'Accept-Ranges': 'bytes',
          'Content-Length': chunksize,
          'Content-Type': 'video/mp4' // Adjust content type based on your video format
        };

        res.writeHead(206, head);
        file.pipe(res);
      } else {
        const head = {
          'Content-Length': fileSize,
          'Content-Type': 'video/mp4' // Adjust content type based on your video format
        };
        res.writeHead(200, head);
        fs.createReadStream(videoPath).pipe(res);
      }
    } else {
      res.status(404).json({ error: 'Video not found' });
    }
  };

  getpdf = (req: Request, res: Response) => {
    const { filename } = req.params;
    const pdfPath = path.join(__dirname, '../uploads/pdfs', filename);

    if (fs.existsSync(pdfPath)) {
      const stat = fs.statSync(pdfPath);
      const fileSize = stat.size;
      const range = req.headers.range;

      if (range) {
        const parts = range.replace(/bytes=/, '').split('-');
        const start = parseInt(parts[0], 10);
        const end = parts[1] ? parseInt(parts[1], 10) : fileSize - 1;
        const chunksize = end - start + 1;
        const file = fs.createReadStream(pdfPath, { start, end });
        const head = {
          'Content-Range': `bytes ${start}-${end}/${fileSize}`,
          'Content-Length': chunksize,
          'Content-Type': 'application/pdf'
        };

        res.writeHead(206, head);
        file.pipe(res);
      } else {
        const head = {
          'Content-Length': fileSize,
          'Content-Type': 'application/pdf'
        };

        res.writeHead(200, head);
        fs.createReadStream(pdfPath).pipe(res);
      }
    } else {
      res.status(404).json({ error: 'PDF not found' });
      return;
    }
  };

  create = async (req: Request, res: Response) => {
    try {
      const hall: hall = {
        name: req.body.name,
        capacity: req.body.capacity,
        city: req.body.city,
        price_hour: req.body.price,
        location: req.body.location,
        details: req.body.details,
        images: req.body.images,
        cover_image: req.body.imageCover,
        pdf: req.body.pdf,
        video: req.body.video,
        user_id: req.body.user_id
      };
      const newhall = await hallobject.create(hall);

      if (newhall) {
        res.json({ status: 'success', data: newhall });
        return;
      }

      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(403);
      res.json({ status: 'fail' });
      return;
    }
  };

  checkHallShowRate = async (req: Request, res: Response) => {
    try {
      const check = await hallobject.CheckForShowRate({
        hallid: req.body.hallid ? req.body.hallid : 0,
        userid: req.body.userid
      });
      // @ts-ignore

      if (!check) {
        res.json({ status: 'success' });
        return;
      }

      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(403);
      res.json({ status: 'fail' });
      return;
    }
  };

  addHallRate = async (req: Request, res: Response) => {
    
    try {
      
      const check = await hallobject.CheckForUserExistRate({
        hallid: req.body.hallid,
        userid: req.body.userid
      });

      // @ts-ignore
      if (!check) {
        const newrate = await hallobject.addRate({
          hallid: req.body.hallid,
          userid: req.body.userid,
          rate: req.body.rate
        });

        if (newrate) {
          res.json({ status: 'success', data: newrate });
          return;
        }
      }
      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(403);
      res.json({ status: 'fail' });
      return;
    }
  };

  update = async (req: Request, res: Response) => {
    try {
      const updated = await hallobject.update(req.body.checked, req.body.id);
      if (updated) {
        res.json({ status: 'success' });
        return;
      }
      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  hallcities = async (_req: Request, res: Response) => {
    try {
      const cities = await hallobject.hallcities();
      if (cities) {
        res.json({ status: 'success', cities: cities });
        return;
      }
      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };
  gethallcodes = async (req: Request, res: Response) => {
    try {
      
      const codes = await hallobject.gethallcodes(req.body.id);
      res.status(200).json({
        status: 'success',
        codes: codes.map((e: any) => {
          return e.code;
        })
      });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };
  delete = async (req: Request, res: Response) => {
    try {
      const deleted = await hallobject.delete(req.params.id);

      if (deleted) {
        res.json({ status: 'success' });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };
}

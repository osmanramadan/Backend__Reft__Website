import { Request, Response } from 'express';
import { User } from '../model/user';
import { user } from '../types/user';
import crypto from 'crypto';
import generatetoken from '../authorization/signtoken';
import sendEmail from '../utils/sendmail';
import Cipher from '../authentication/bcrypt';

const userobject = new User();
const cipher = new Cipher();

export default class UserController {
  index = async (_req: Request, res: Response) => {
    try {
      const allusers = await userobject.index();
      res.json(allusers);
      return;
    } catch (e) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  show = async (id: number) => {
    const userbyid = await userobject.show(id);
    if (userbyid) {
      return userbyid;
    }
  };

  showuserbytoken = async (req: Request, res: Response) => {
    try {
      // @ts-ignore
      const userbyid = await userobject.show(req.userid as unknown as number);
      // @ts-ignore
      delete userbyid.password;
      delete userbyid.password_changed_at;
      delete userbyid.password_verified_code;
      delete userbyid.reset_code_verified;
      delete userbyid.password_reset_expires;

      if (userbyid) {
        res.json({ status: 'success', data: userbyid });
        return;
      }
      res.status(400);
      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  delete = async (req: Request, res: Response) => {
    try {
      const deleted = await userobject.deleteuser(req.params.id);
      res.json(deleted);
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  getuserbycredentials = async (req: Request, res: Response) => {
    try {
      const existemail = await userobject.emailExists(req.body.email);
      if (existemail) {
        const userbyemail = await userobject.getuserbycredentials(
          req.body.email,
          req.body.password
        );

        if (userbyemail) {
          const token = await generatetoken(userbyemail);
          delete userbyemail.password;
          delete userbyemail.password_changed_at;
          delete userbyemail.password_reset_expires;
          delete userbyemail.reset_code_verified;
          delete userbyemail.password_verified_code;

          res.json({ data: userbyemail, token: token });
          return;
        } else {
          res.json({ error: 'Password wrong' });
          return;
        }
      } else {
        res.status(404);
        res.json({ error: 'Email not found' });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  getuserbyemail = async (req: Request, res: Response) => {
    try {
      const existemail = await userobject.emailExists(req.body.email);

      if (existemail) {
        const userbyemail = await userobject.getuserbyemail(req.body.email);
        if (userbyemail) {
          res.json(userbyemail);
          return;
        } else {
          res.json({ error: 'User not found' });
          return;
        }
      } else {
        res.status(404);
        res.json({ error: 'Email not found' });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  create = async (req: Request, res: Response) => {
    try {
      // @ts-ignore
      const userquery: user = {
        email: req.body.email,
        username: req.body.username,
        password: req.body.password,
        phone: req.body.phone,
        city: req.body.city,
        role: req.body.role
      };

      const existemail = await userobject.emailExists(req.body.email);

      if (existemail) {
        res.json({ error: 'Email already exist' });
        return;
      }

      const existphone = await userobject.phoneExists(req.body.phone);
      if (existphone) {
        res.json({ error: 'Phone already exist' });
        return;
      }

      const newuser = await userobject.create(userquery);
      delete newuser.password;
      delete newuser.password_changed_at;
      delete newuser.password_reset_expires;
      delete newuser.password_verified_code;
      delete newuser.reset_code_verified;

      const token = await generatetoken(newuser);
      res.json({ token: token });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  forgetpassword = async (req: Request, res: Response) => {
    const { email } = req.body;
    try {
      const existemail = await userobject.emailExists(email);
      if (!existemail) {
        res.status(404);
        res.json({ status: 'fail' });
        return;
      }
      const generateRandomSixDigitCode = () => {
        const min = 100000; // Minimum value for a six-digit number
        const max = 999999; // Maximum value for a six-digit number
        const randomCode = Math.floor(Math.random() * (max - min + 1)) + min;
        return randomCode.toString();
      };

      const resetCode = generateRandomSixDigitCode();
      const hashedResetCode = crypto
        .createHash('sha256')
        .update(resetCode)
        .digest('hex');
      const passwordResetExpires = new Date(Date.now() + 10 * 60 * 1000);
      const resetCodeVerified = false;

      const updated = await userobject.updateUserFields({
        email: email,
        password_verified_code: hashedResetCode,
        password_reset_expires: passwordResetExpires,
        reset_code_verified: resetCodeVerified
      });

      if (!updated) {
        res.status(400);
        res.json({ status: 'fail to update' });
        return;
      }
      const message = `Forgot your password ? Submit this reset password code:
            ${resetCode}\n If you didn't forget your password, please ignore this email!`;

      await sendEmail({
        email: email,
        subject: 'Your Password Reset Code (valid for 10 min)',
        message,
        resetCode: resetCode
      });

      res.status(200).json({
        status: 'success',
        message: 'Reset code sent to your email'
      });
      return;
    } catch (err) {
      await userobject.updateUserFields({
        email: email,
        reset_code_verified: undefined,
        password_reset_expires: undefined,
        password_verified_code: undefined
      });
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  verifyresetcode = async (req: Request, res: Response) => {
    try {
      const existemail = await userobject.emailExists(req.body.email);
      if (!existemail) {
        res.status(404);
        res.json({ status: 'email not found' });
        return;
      }

      const hashedResetCode = crypto
        .createHash('sha256')
        .update(req.body.resetCode)
        .digest('hex');

      const result = await userobject.checkResetCode(
        req.body.email,
        hashedResetCode
      );
      if (result === 'invalid code') {
        res.status(400);
        res.json({ status: 'invalid code' });
        return;
      }

      if (result === 'expired code') {
        res.status(400);
        res.json({ status: 'expired code' });
        return;
      }

      const check = await userobject.checkVerifyCode(req.body.email);
      if (check) {
        res.status(400);
        res.json({ status: 'already verified' });
        return;
      }

      const updated = await userobject.updateUserFields({
        email: req.body.email,
        reset_code_verified: true
      });

      if (updated) {
        res.status(200);
        res.json({ status: 'success' });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  resetpassword = async (req: Request, res: Response) => {
    try {
      const result = await userobject.emailExists(req.body.email);

      if (!result) {
        res.status(400);
        res.json({ status: 'fail' });
        return;
      }

      const check = await userobject.checkVerifyCode(req.body.email);
      if (!check) {
        res.status(400);
        res.json({ status: 'fail' });
        return;
      }
      const hash = await cipher.encrypt(req.body.newpassword);
      const updated = await userobject.updateUserFields({
        email: req.body.email,
        password: hash,
        reset_code_verified: undefined,
        password_reset_expires: undefined,
        password_verified_code: undefined
      });

      if (updated) {
        const userData: user = await userobject.getuserbyemail(req.body.email);
        const token = await generatetoken(userData);
        res.status(200);
        res.json({ status: 'success', token: token });
        return;
      }

      res.status(400);
      res.json({ status: 'unupdated' });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };

  updateuserprofile = async (req: Request, res: Response) => {
    try {
      const existemail = await userobject.emailExists(req.body.email);
      if (existemail) {
        const data = {
          email: req.body.email,
          name: req.body.username,
          phone: req.body.phone,
          city: req.body.city
        };
        const updated = await userobject.updateUserFields(data);

        if (updated) {
          const userbyemail = await userobject.getuserbyemail(req.body.email);
          res.status(200);
          res.json({ status: 'success', data: userbyemail });
          return;
        }
      } else {
        res.status(404);
        res.json({ status: 'fail' });
        return;
      }

      res.status(400);
      res.json({ status: 'fail' });
      return;
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
    }
  };

  updateuserpassword = async (req: Request, res: Response) => {
    try {
      const existemail = await userobject.emailExists(req.body.email);
      if (existemail) {
        const updated = await userobject.updateuserpassword(
          req.body.email,
          req.body.oldpassword,
          req.body.newpassword
        );
        if (updated) {
          res.status(200);
          res.json({ status: 'success' });
          return;
        } else {
          res.json({ status: 'fail' });
          return;
        }
      } else {
        res.json({ status: 'email fail' });
        return;
      }
    } catch (err) {
      res.status(400);
      res.json({ status: 'fail' });
      return;
    }
  };
}

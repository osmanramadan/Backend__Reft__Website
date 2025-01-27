"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = __importDefault(require("express"));
const checkout_1 = __importDefault(require("../../controller/checkout"));
// import { messageValidator } from '../../utils/validator/messageValidator';
const Paycontroller = new checkout_1.default();
const payment = express_1.default.Router();
payment.post('/createorderpaypal', Paycontroller.createOrderPaypal);
payment.post('/createorderstripe', Paycontroller.createOrderStripe);
payment.post('/capturepaymentpaypal', Paycontroller.captureorderpaypal);
payment.post('/capturepaymentstripe', Paycontroller.captureorderstripe);
payment.post('/hallcodes', Paycontroller.gethallcodes);
exports.default = payment;

#! /usr/bin/env node
import express from 'express'
import cors from 'cors'
import fs from 'fs'
import {config} from 'dotenv'
if (process.env.NODE_ENV !== 'production') {
  config()
}

const quotes = JSON.parse(fs.readFileSync('quotes.json'))
// using readFileSync because it's literally the only thing we're reading/importing/processing

const getRandomQuote = () => {
  return quotes[Math.floor(Math.random() * quotes.length)]
}
const getDailyQuote = () => {
  const d = new Date()
  const t = d.getTime()
  return quotes[1 + ((Math.round(t / 28800000) * 509) % 779)]
}

const app = express()

app.use(cors())
app.get('/', (_, res) => {
  const quote = getRandomQuote()
  res.send(quote)
})

app.get('/daily', (_, res) => {
  const quote = getDailyQuote()
  res.send(quote)
})

app.get('/all-quotes', (_, res) => {
  res.send(quotes)
})

app.listen(process.env.PORT || 80, () => console.log("listening on port", process.env.PORT))

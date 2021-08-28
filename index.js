import express from 'express'
import fs from 'fs'

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

app.get('/', (req, res) => {
  const quote = getRandomQuote()
  res.send(quote)
})

app.get('/daily', (req, res) => {
  const quote = getDailyQuote()
  res.send(quote)
})

app.listen(4000, () => {})

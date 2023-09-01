faker = require 'faker'
_     = require 'underscore'

PayLater = () ->

  it 'works with pay later and reminders', ->
    data = _.clone @data
    data = _.extend(data,
      {
        pay_later: true,
        reminder_language: faker.random.arrayElement([
          "en", "it", "es", "fr", "de", "pl", "ja", "zh",
          "ar", "pt", "tr", "ru", "hi", "bg", "nl", "is",
          "id", "ms", "th", "cs", "hr", "sl", "fi", "no",
          "da", "sv"
          ]),
        reminders: [
          {
            "channel": "email",
            "after": 40
          },
          {
            "channel": "sms",
            "after": 10
          }
        ]
      }
    )

    assert.equal true, @transaction.setData(data).isValid()

  it 'fails with invalid language code', ->
    data = _.clone @data
    data = _.extend(data,
      {
        pay_later: true,
        reminder_language: "INVALID_LANGUAGE",
        reminders: [
          {
            "channel": "email",
            "after": 40
          },
          {
            "channel": "sms",
            "after": 10
          }
        ]
      }
    )

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails with more than 3 reminders', ->
    data = _.clone @data
    data = _.extend(data,
      {
        pay_later: true,
        reminder_language: faker.random.arrayElement([
          "en", "it", "es", "fr", "de", "pl", "ja", "zh",
          "ar", "pt", "tr", "ru", "hi", "bg", "nl", "is",
          "id", "ms", "th", "cs", "hr", "sl", "fi", "no",
          "da", "sv"
        ]),
        reminders: [
          {
            "channel": "email",
            "after": 40
          },
          {
            "channel": "sms",
            "after": 10
          },
          {
            "channel": "sms",
            "after": 10
          },
          {
            "channel": "sms",
            "after": 10
          }
        ]
      }
    )

    assert.equal false, @transaction.setData(data).isValid()

  it 'fails with reminders and without pay_later', ->
    data = _.clone @data
    data = _.extend(data,
      {
        reminder_language: "INVALID_LANGUAGE",
        reminders: [
          {
            "channel": "email",
            "after": 40
          },
          {
            "channel": "sms",
            "after": 10
          }
        ]
      }
    )

    assert.equal false, @transaction.setData(data).isValid()

module.exports = PayLater


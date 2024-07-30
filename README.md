# Note

<!-- MarkdownTOC -->

- [About](#about)
  - [How does it work?](#how-does-it-work)
- [Setup](#setup)
  - [Telegram chatbot](#telegram-chatbot)
    - [Create Telegram chatbot](#create-telegram-chatbot)
    - [Get Telegram user info](#get-telegram-user-info)
    - [Get Telegram token](#get-telegram-token)
  - [g0v archive RSS feeds](#g0v-archive-rss-feeds)
- [Hack in this repo](#hack-in-this-repo)

<!-- /MarkdownTOC -->


## About

This experimental project was designed for the following scenario. Retrieving RSS feed from g0v archive and send to Telegram via chatbot after filtering out non-open sesame messages.

### How does it work?

Here's the source channel.
https://g0v-slack-archive.g0v.ronny.tw/index/rss/C0385B90D

Here's the data pipeline.
Slack webhook => g0v archive => RSS feed => RSS-Bridge => RSStT => Telegram

## Setup

### Telegram chatbot

#### Create Telegram chatbot

https://t.me/BotFather

> Done! Congratulations on your new bot. You will find it at t.me/NPOHUBOpenSesameBot. You can now add a description, about section and profile picture for your bot, see /help for a list of commands. By the way, when you've finished creating your cool bot, ping our Bot Support if you want a better username for it. Just make sure the bot is fully operational before you do this.

#### Get Telegram user info

https://t.me/userinfobot

#### Get Telegram token

Ref:
https://telegra.ph/api#createAccount

### g0v archive RSS feeds

Here's an example for filtering out "希望有人來開門"
```
http://rss-bridge/?action=display&bridge=FilterBridge&url=https%3A%2F%2Fg0v-slack-archive.g0v.ronny.tw%2Findex%2Frss%2FC0385B90D&filter=.*希望有人來開門.*&filter_type=permit&case_insensitive=on&target_title=on&title_from_content=on&length_limit=-1&format=Atom
```

## Hack in this repo

- RSS-Bridge cache changes to 10 seconds from 3600
  <https://github.com/RSS-Bridge/rss-bridge/blob/0eac7a078479eac48be6c841a79f77ff04f429a8/Dockerfile#L72>
- RSStT minimum refresh time changes to seconds from minutes
  <https://github.com/Rongronggg9/RSS-to-Telegram-Bot/blob/6ae43afb4a8e60281ef89c03943ff139e955fcad/Dockerfile#L135>

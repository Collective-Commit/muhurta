# Muhurta
Muhurta is an open source collaboration tool for organising events and meetings with ease.


Built with [Elixir](https://github.com/elixir-lang/elixir), [Phoenix](https://github.com/phoenixframework/phoenix), [TailwindCSS](https://github.com/tailwindlabs/tailwindcss) & several other open source libraries.

## What is in the name?
"Muhurta" refers to a traditional unit of time in ancient Indian systems of timekeeping. One Muhurta is approximately equal to 48 minutes. This unit is part of a larger system where the day is divided into 30 Muhurtas, covering both day and night. Muhurta is also a concept in Vedic astrology that identifies favorable times to start significant activities or events. 

The practice of choosing a Muhurta is deeply rooted in Indian culture and continues to be an integral part of planning important life events. 

## Get started

1. Clone the repository switch to the project directory

   ```bash
   git clone git@github.com:Collective-Commit/muhurta.git
   cd muhurta
   ```

2. Install dependencies

   ```
   mix setup
   ```

3. Setup the database

   The app uses postgresql database. Make changes if necessary to the database credentials in `config/dev.exs`

4. Start the Phoenix server

   ```
   mix phx.server
   ```

5. View on browser

   Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

6. Setup Git hooks
   
   This is a recommended approach to ensure all code submitted for review is formatted first. Run the following command to setup hooks on your machine so that only formatted code gets committed to the repo.

   ```
   ./setup-hooks.sh
   ```


## Contributors

Please read our [contributing guide](CONTRIBUTING.md) to learn about how to contribute to this project.

### Translators 🌐

Currently the app is available only in English but we have plans to introduce localisation. This section will be updated when we introduce localisation support.

## License

Muhurta is open-source under the Unlicense. See [LICENSE](LICENSE) for more detail.

## Sponsors
Muhurta is our open-source project dedicated to simplifying meeting and event scheduling. If you like the project and our vision, consider [sponsoring on Open Collective](https://opencollective.com/collective-commit) to show your support. Your support can help enhance collaboration everywhere.


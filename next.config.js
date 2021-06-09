module.exports = {
  webpack: (config, options) => {
    const isProd = process.env.NODE_ENV === "production";
    config.module.rules.push({
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: {
        loader: "elm-webpack-loader",
        options: Object.assign(
          {},
          { optimize: isProd },
          !isProd
            ? {
                runtimeOptions: ["-A128M", "-H128M", "-n8m"],
              }
            : { debug: true }
        ),
      },
    });
    return config;
  },
};

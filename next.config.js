module.exports = {
  webpack: (config, options) => {
    config.module.rules.push({
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: {
        loader: "elm-webpack-loader",
        options: {
      runtimeOptions: ['-A128M', '-H128M', '-n8m']


        },
      },
    });
    return config;
  },
};

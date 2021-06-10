module.exports = {
  webpack: (config, options) => {
    const isProd = process.env.NODE_ENV === "production";

    const elmLoader = {
      loader: "elm-webpack-loader",
      options: Object.assign(
        {},
        { optimize: isProd },
        !isProd
          ? {
              runtimeOptions: ["-A128M", "-H128M", "-n8m"],
              debug: true,
            }
          : {}
      ),
    };
    config.module.rules.push({
      test: /\.elm$/,
      exclude: [/elm-stuff/, /node_modules/],
      use: isProd
        ? elmLoader
        : [{ loader: "elm-hot-webpack-loader" }, elmLoader],
    });
    return config;
  },
};

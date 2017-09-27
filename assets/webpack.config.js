const path = require("path");
const CopyWebpackPlugin = require("copy-webpack-plugin");


module.exports = (env) => {
  return {
    devtool: "eval",
    entry: {
      app: "./js/app.js"
    },
    output: {
      path: path.resolve(__dirname, "../priv/static"),
      filename: "js/[name].js",
      publicPath: "http://localhost:8080/"
    },
    resolve: {
      modules: ["node_modules", __dirname],
      extensions: [".js", ".json"]
    },
    plugins: [
      new CopyWebpackPlugin([{
        from: "./css",
        to: path.resolve(__dirname, "../priv/static/css"),
      }])
    ]
  };
};

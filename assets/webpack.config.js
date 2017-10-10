const path = require("path");
const ExtractTextPlugin = require("extract-text-webpack-plugin");


module.exports = (env) => {
  return {
    devtool: "eval",
    entry: {
      app: [
        "./js/app.js",
        "./styles/app.scss",
        "./styles/forms.scss"
      ]
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
    module: {
      rules: [
        {
          test: /\.(scss|sass|css)$/,
          use: ExtractTextPlugin.extract({
            fallback: "style-loader",
            use: ["css-loader", "sass-loader"]
          })
        }
      ]
    },
    plugins: [
      new ExtractTextPlugin({
        filename: "css/[name].css"
      })
    ]
  };
};

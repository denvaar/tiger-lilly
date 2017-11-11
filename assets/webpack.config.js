const path = require("path");
const ExtractTextPlugin = require("extract-text-webpack-plugin");
const CopyWebpackPlugin = require("copy-webpack-plugin");


module.exports = (env) => {
  return {
    devtool: "eval",
    entry: {
      app: [
        "./js/app.js",
        "./styles/main.scss",
        "./styles/posts.scss",
        "./styles/forms.scss"
      ],
      posts: [
        "./styles/posts.scss"
      ],
      edit_post: [
        "./js/flatpickr.js",
        "./node_modules/flatpickr/dist/flatpickr.min.css",
        "./node_modules/flatpickr/dist/themes/dark.css"
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
          test: /\.js$/,
          loader: 'babel-loader',
          query: {
            presets: ['es2015']
          }
        },
        {
          test: /\.(scss|sass|css)$/,
          exclude: /styles/,
          loader: 'style-loader!css-loader!sass-loader?outputStyle=expanded'
        },
        {
          test: /\.(scss|sass|css)$/,
          exclude: /node_modules/,
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
      }),
      new CopyWebpackPlugin([
        {
          from: "./js/highlight.pack.js",
          to: path.resolve(__dirname, "../priv/static/js")
        },
        {
          from: "./styles/ocean.css",
          to: path.resolve(__dirname, "../priv/static/css")
        }
      ],
      {
        copyUnmodified: true
      })
    ]
  };
};

/* global Vue, VueRouter, axios */

var HomePage = {
  template: "#home-page",
  data: function() {
    return {
      game: "",
      board: [],
      amountImages: 10,
      tagName: "ski_jumping",
      errors: []
    };
  },
  created: function() {},
  methods: {
    play: function(argument) {
      var params = {
        amount_images: this.amountImages,
        tag_name: this.tagName
      };
      axios
        .post("/games", params)
        .then(
          function(response) {
            console.log("starting created");
            console.log("response from post games");
            console.log(response.data);
            this.game = response.data;
            this.board = this.game.board;
            // console.log("Hello");
            // console.log(this.board);
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = ["No no no."];
          }.bind(this)
        );
    },
    flip: function(card) {
      console.log("starting flip");
      console.log(card);
      var parameters = { status: "flipped" };
      axios
        .patch("/game_images/" + card.game_image_id, parameters)
        .then(
          function(response) {
            console.log(response.data);
            this.show();
            console.log("flip");
            // router.push("/");
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    show: function() {
      console.log("starting show");
      console.log(this.game.id);
      axios
        .get("/games/" + this.game.id)
        .then(
          function(response) {
            this.game = "";
            this.boar = [];

            this.game = response.data;
            this.board = this.game.board;
            console.log(this.board);
            console.log("show");
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  },
  computed: {}
};

// Authorization Components

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      name: "",
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        name: this.name,
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        auth: { email: this.email, password: this.password }
      };
      axios
        .post("/user_token", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var LogoutPage = {
  template: "#home-page",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var router = new VueRouter({
  routes: [
    { path: "/", component: HomePage },
    { path: "/games", component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: "#vue-app",
  router: router,
  created: function() {
    var jwt = localStorage.getItem("jwt");
    console.log(jwt);
    if (jwt) {
      axios.defaults.headers.common["Authorization"] = jwt;
    }
  }
});

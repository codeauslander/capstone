/* global Vue, VueRouter, axios */

var PlayPage = {
  template: "#play-page",
  data: function() {
    return {
      game: "",
      board: [],
      amountImages: 4,
      tagName: "ski_jumping",
      tags: [],
      errors: [],
      settings: false
    };
  },
  created: function() {
    this.listTags();
  },
  methods: {
    isSettings: function() {
      this.settings = !this.settings;
    },
    listTags: function() {
      axios.get("/tags").then(
        function(response) {
          this.tags = response.data;
          console.log(this.tags);
        }.bind(this)
      );
    },
    play: function(argument) {
      this.settings = true;
      var params = {
        amount_images: this.amountImages,
        tag_name: this.tagName
      };
      axios
        .post("/games", params)
        .then(
          function(response) {
            console.log(response.data);
            this.game = response.data;
            this.board = this.game.board;
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = ["No no no."];
          }.bind(this)
        );
    },
    flip: function(card) {
      var parameters = { status: "flipped" };
      console.log(
        " card.game_image_id" + card.game_image_id + "image_id" + card.image_id
      );
      axios
        .patch("/game_images/" + card.game_image_id, parameters)
        .then(
          function(response) {
            this.show();
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
      this.isActive = !this.isActive;
    },
    show: function() {
      axios
        .get("/games/" + this.game.id)
        .then(
          function(response) {
            // this.game = "";
            // this.boar = [];
            console.log("this.board before");
            console.log(
              this.board.map(function(card_row) {
                return card_row.map(function(card) {
                  return card.game_image_id;
                });
              })
            );

            this.game = response.data;
            this.board = response.data.board;
            console.log("this.board after");
            console.log(
              this.board.map(function(card_row) {
                return card_row.map(function(card) {
                  return card.game_image_id;
                });
              })
            );
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    isFlipped: function(card) {
      if (card.status === "flipped" || card.status === "viewed") {
        return true;
      }
      return false;
    },
    isNormal: function(card) {
      if (card.status === "normal") {
        return true;
      }
      return false;
    },
    isOk: function(card) {
      if (card.status === "ok") {
        return true;
      }
      return false;
    }
  },
  computed: {}
};

var TagsPage = {
  template: "#tags-page",
  data: function() {
    return {
      newName: "",
      newImageIds: "",
      showNewTagForm: false,

      newImageName: "",
      newImageUrl: "",
      showNewImageForm: false,

      tags: []
    };
  },
  created: function() {
    this.indexTags();
  },
  methods: {
    indexTags: function() {
      axios.get("/tags").then(
        function(response) {
          this.tags = response.data;
          console.log(this.tags);
        }.bind(this)
      );
    },
    createTag: function() {
      var parameters = { name: this.newName, image_ids: this.newImageIds };
      axios
        .post("/tags", parameters)
        .then(
          function(response) {
            this.tags.push(response.data);
            this.newName = "";
            this.newImageIds = "";
          }.bind(this)
        )
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    },
    newTagForm: function() {
      return (this.showNewTagForm = !this.showNewTagForm);
    },
    deleteTag: function(tag) {
      axios.delete("/tags/" + tag.id).then(
        function(response) {
          var index = this.tags.indexOf(tag);
          this.tags.splice(index, 1);
        }.bind(this)
      );
    },
    createImageInTag: function(tag) {
      var parameters = {
        tag_ids: [tag.id],
        image_url: this.newImageUrl,
        name: this.newImageName
      };
      console.log(parameters);
      axios.post("/images", parameters).then(
        function(response) {
          var index = this.tags.indexOf(tag);
          this.tags[index].images.push(response.data);
          this.newImageUrl = "";
          this.newImageName = "";
        }.bind(this)
      );
    },
    newImageForm: function() {
      return (this.showNewImageForm = !this.showNewImageForm);
    },
    deleteImageFromTag: function(tag, image) {
      var index = tag.images.indexOf(image);
      var id = tag.image_tags[index].id;
      axios.delete("/image_tags/" + id).then(
        function(response) {
          var index_tag = this.tags.indexOf(tag);
          this.tags[index_tag].images.splice(index, 1);
          console.log(response.data);
        }.bind(this)
      );
    }
  },
  computed: {}
};

var ImagesPage = {
  template: "#images-page",
  data: function() {
    return {
      images: [],
      allTags: [],
      newImageName: ""
    };
  },
  methods: {
    uploadFile: function(event) {
      if (event.target.files.length > 0) {
        var formData = new FormData();
        formData.append("name", this.newImageName);
        formData.append("image_url", event.target.files[0]);

        axios.post("/images", formData).then(
          function(response) {
            console.log(response);
            this.newImageName = "";
            event.target.value = "";
          }.bind(this)
        );
      }
    },

    indexImages: function() {
      axios.get("/images").then(
        function(response) {
          this.images = response.data;
        }.bind(this)
      );
    },
    addTag: function(image, tag) {
      var parameters = { tag_id: tag.id };
      axios.patch("/images/" + image.id, parameters).then(
        function(response) {
          var index = this.images.indexOf(image);
          this.images[index].tags.push(tag);
        }.bind(this)
      );
    },
    listTags: function() {
      axios.get("/tags").then(
        function(response) {
          this.allTags = response.data;
          console.log(this.allTags);
        }.bind(this)
      );
    },
    deleteTagFromImage: function(image, tag) {
      var index = image.tags.indexOf(tag);
      var id = image.image_tags[index].id;
      axios.delete("/image_tags/" + id).then(
        function(response) {
          var index_image = this.images.indexOf(image);
          this.images[index_image].tags.splice(index, 1);
          console.log(response.data);
        }.bind(this)
      );
    }
  },
  created: function() {
    this.indexImages();
    this.listTags();
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
    { path: "/", component: PlayPage },
    { path: "/games", component: PlayPage },
    { path: "/tags", component: TagsPage },
    { path: "/images", component: ImagesPage },

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

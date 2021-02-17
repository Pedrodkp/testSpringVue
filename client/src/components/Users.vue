<template>
    <div class="container">
        <div class="row">
            <div class="col-sm-10">
                <h1>Users</h1>
                <hr><br><br>
                <alertcrud :message="message" v-if="showMessage"></alertcrud>
                <button type="button" class="btn btn-success btn-sm"
                        v-b-modal.user-modal
                        @click="addUser()">Add User</button>
                <br><br>
                <table class="table table-hover">
                    <thead>
                        <tr>
                            <th scope="col">Nome</th>
                            <th scope="col">Idioma</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(user, index) in users" :key="index">
                            <td>{{ user.name }}</td>
                            <td>{{ user.language_description }}</td>
                            <td>
                                <div class="btn-group" role="group">
                                    <button type="button"
                                            class="btn btn-warning btn-sm"
                                            v-b-modal.user-modal
                                            @click="editUser(user)">
                                        Update
                                    </button>
                                    <button type="button"
                                            class="btn btn-danger btn-sm"
                                            @click="onDeleteUser(user)">
                                        Delete
                                    </button>
                                </div>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>

        <b-modal ref="userModal"
                 id="user-modal"
                 :title=this.modalTitle
                 hide-footer>
          <b-form @submit="onSubmit" @reset="onReset" class="w-100">
            <b-form-group id="form-title-group"
                          label="Title:"
                          label-for="form-title-input">
              <b-form-input id="form-title-input"
                            type="text"
                            v-model="userForm.title"
                            required
                            placeHolder="Enter title">
              </b-form-input>
            </b-form-group>
            <b-form-group id="form-author-group"
                          label="Author:"
                          label-for="form-author-input">
              <b-form-input id="form-author-input"
                            type="text"
                            v-model="userForm.author"
                            required
                            placeHolder="Enter author">
              </b-form-input>
            </b-form-group>
            <b-form-group id="form-read-group">
              <b-form-checkbox-group v-model="userForm.read" id="form-checks">
                <b-form-checkbox value="true">Read?</b-form-checkbox>
              </b-form-checkbox-group>
            </b-form-group>
            <b-button-group>
              <b-button type="submit" variant="primary">Submit</b-button>
              <b-button type="reset" variant="danger">Cancel</b-button>
            </b-button-group>
          </b-form>
        </b-modal>

    </div>
</template>

<script>
import axios from 'axios';
import AlertCrud from './Alert.vue';

export default {
  name: 'UsersCrud',
  data() {
    return {
      users: [],
      userForm: {
        id: '',
        title: '',
        author: '',
        read: [],
      },
      message: '',
      modalTitle: '',
      showMessage: false,
    };
  },
  components: {
    alertcrud: AlertCrud,
  },
  methods: {
    getUsers() {
      const path = 'http://localhost:8080/api/v1/users';
      axios.get(path)
        .then((res) => {
          this.users = res.data;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
        });
    },
    user(payload) {
      const path = 'http://localhost:8080/api/v1/users';
      axios.post(path, payload)
        .then(() => {
          this.getUsers();
          this.message = 'User added!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.log(error);
          this.getUsers();
        });
    },
    updateUser(payload, userID) {
      const path = `http://localhost:8080/api/v1/users/${userID}'`;
      axios.put(path, payload)
        .then(() => {
          this.getUsers();
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
          this.getUsers();
        });
    },
    removeUser(userID) {
      const path = `http://localhost:8080/api/v1/users/${userID}`;
      axios.delete(path)
        .then(() => {
          this.getUsers();
          this.message = 'User removed!';
          this.showMessage = true;
        })
        .catch((error) => {
          // eslint-disable-next-line
          console.error(error);
          this.getUsers();
        });
    },
    initForm() {
      this.userForm.id = '';
      this.userForm.title = '';
      this.userForm.author = '';
      this.userForm.read = [];
    },
    addUser() {
      this.modalTitle = 'Add new user';
    },
    editUser(user) {
      this.userForm = user;
      this.modalTitle = `Edit the user ${user.id}`;
    },
    onSubmit(evt) {
      evt.preventDefault();
      this.$refs.userModal.hide();
      let read = false;
      if (this.userForm.read[0]) read = true;
      const payload = {
        title: this.userForm.title,
        author: this.userForm.author,
        read,
      };
      if (this.userForm.id) {
        this.updateUser(payload, this.editForm.id);
      } else {
        this.user(payload);
      }
      this.initForm();
    },
    onReset(evt) {
      evt.preventDefault();
      this.$refs.userModal.hide();
      this.initForm();
      this.getUsers();
    },
    onDeleteUser(user) {
      // eslint-disable-next-line
      if (confirm('Do you really want to delete?')) {
        this.removeUser(user.id);
      }
    },
  },
  created() {
    this.getUsers();
  },
};
</script>

export const environment = {
  production: true,
  apiURL: window["env"]["apiUrl"] ||  'http://localhost:8080',
  clientId: 'my-angular-app',
  clientSecret: '@321',
  obterTokenUrl: '/oauth/token'
};

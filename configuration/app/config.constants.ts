const HOST = 'xxxxxxx';
const EXTERNAL_IP = 'xxxxxx';

const access_localhost = false;

export const SERVER_DOMAIN = access_localhost ? HOST : EXTERNAL_IP;
export const SERVER_PORT = 4000;
export const SERVER_SCHEMA = 'https'

export const API_SERVER = `${SERVER_SCHEMA}://${SERVER_DOMAIN}:${SERVER_PORT}`;
export const GRAPHQL_SERVER = `${API_SERVER}/graphql`
export const REST_SERVER = `${API_SERVER}/api`
String getExceptionMessage(Exception message) {
  return message.toString().split(': ')[1];
}

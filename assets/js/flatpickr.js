import flatpickr from 'flatpickr';


flatpickr("#postDate", {
  enableTime: true,
  defaultDate: new Date,
  dateFormat: 'Z',
  altInput: true,
  theme: 'dark'
});

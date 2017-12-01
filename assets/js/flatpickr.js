import flatpickr from 'flatpickr';


flatpickr("#postDate", {
  enableTime: true,
  defaultDate: document.getElementById("postDate").value || new Date,
  dateFormat: 'Z',
  altInput: true,
  theme: 'dark'
});

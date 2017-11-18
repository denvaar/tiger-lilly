/* buiild required markup */
const selectElement = document.querySelector(".tag");

const tagContainer = document.createElement('div');
tagContainer.classList.add('tag-container');

const tagSelectedContainer = document.createElement('span');
tagSelectedContainer.classList.add('tag-selected-container');
tagContainer.appendChild(tagSelectedContainer);

const tagInput = document.createElement('input');
tagInput.type = 'text';
tagInput.placeholder = 'Tags';
tagContainer.appendChild(tagInput);
selectElement.parentNode.appendChild(tagContainer);

const createStore = (reducerFunction) => {
  let state; /* only place state is allowed to change */
  let listeners = [];

  const getState = () => state;

  const dispatch = (action) => {
    state = reducerFunction(state, action);
    listeners.forEach(listener => listener());
  };

  const subscribe = (listener) => {
    listeners.push(listener);

    return () => {
      listeners = listeners.filter(l => l !== listener);
    };
  };

  dispatch({}); /* force initial state to be applied */

  return { getState, dispatch, subscribe };
};

const initialState = {
  tags: Array.from(selectElement.options).map(option => (
    {
      name: option.text,
      selected: option.selected
    }
  ))
};

const tagReducer = (state = initialState, action) => {
  switch (action.type) {
    case 'ADD_TAG':
      return {
        tags: [
          ...state.tags,
          {
            name: action.name,
            selected: true
          }
        ]
      };
    case 'TOGGLE_SELECT':{
      const indexToSelect = state.tags.findIndex(
        tag => tag.name == action.name);
      return {
        tags: [
          ...state.tags.slice(0, indexToSelect),
          {
            ...state.tags[indexToSelect],
            selected: action.selected
          },
          ...state.tags.slice(indexToSelect + 1)
        ]
      };
    }
    default:
      return state;
  };
};

const store = createStore(tagReducer);

const renderTags = () => {
  const createTag = (val) => {
    const t = document.createElement('span');
    t.innerHTML = `<i class="fa fa-tag" aria-hidden="true"></i> ${val}`;
    t.classList.add('tag-item');
    tagSelectedContainer.appendChild(t);
    return t;
  };

  const tags = store.getState().tags.filter(tag => tag.selected);

  tagSelectedContainer.innerHTML = '';
  tags.forEach(tag => {
    createTag(tag.name)
  });
  const totalWidth = tagSelectedContainer.getBoundingClientRect().width
  tagInput.style.paddingLeft = `${totalWidth + 12}px`;

  if (tags.length < 1) tagInput.placeholder = 'Tags';
  else tagInput.placeholder = '';
};

const selectValue = (val, selected) => {
  const option = Array.from(selectElement.options).find(op => op.text == val);
  if (option) {
    option.selected = selected;
  } else {
    /* create new tag on server */
    console.log('tag does not exist yet');
  }
};

const updateSelectInput = () => {
  const tags = store.getState().tags;
  tags.forEach(tag => {
    selectValue(tag.name, tag.selected)
  });
};

store.subscribe(renderTags);
store.subscribe(updateSelectInput);

renderTags();

tagInput.onkeydown = (event) => {
  const key = event.keyCode || event.charCode;
  if (key == 13) {
    if (store.getState().tags.find(tag => tag.name == event.target.value)) {
      store.dispatch({
        type: 'TOGGLE_SELECT',
        name: event.target.value,
        selected: true
      });
    } else {
      store.dispatch({
        type: 'ADD_TAG',
        name: event.target.value,
        selected: true
      });
    }

    event.target.value = "";
    return false;
  }

  if (key == 8 && event.target.value.length < 1) {
    const tags = store.getState().tags.filter(tag => tag.selected);
    if (tags.length > 0) {
      store.dispatch({
        type: 'TOGGLE_SELECT',
        name: tags[tags.length - 1].name,
        selected: false
      });
    }
  }
};

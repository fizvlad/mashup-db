function update_list(data) {
  let sources_list = jQuery('#sources_list');
  sources_list.empty();
  data.forEach(function(element) {
    sources_list.append(`
      <li class="list-group-item d-flex justify-content-between align-items-center">
        <span>
          <span class="artist">${element.artist}</span> - <span class="title">${element.title}</span>
        </span>
        <button class="btn btn-secondary remove_sources_button" type="button">
          <i class="fas fa-minus-circle"></i>
        </button>
      </li>
    `);
  });
  jQuery('.remove_sources_button').click(remove_source_click);
}

function add_source_click(event) {
  let artist_field = jQuery('#add_sources_artist');
  let artist = artist_field.val().trim();
  let title_field = jQuery('#add_sources_title');
  let title = title_field.val().trim();

  re = jQuery.ajax({
    'data': {
      'sources': {
        'type': 'add',
        'artist': artist,
        'title': title
      }
    },
    'method': 'PUT',
    'url': `${window.location.pathname}/sources`
  }).done(function(data, textStatus, jqXHR) {
    update_list(data);
    // Reset form
    artist_field.val('');
    title_field.val('');
    artist_field.removeClass('is-invalid');
    title_field.removeClass('is-invalid');
    jQuery('#add_sources_error').empty();
  }).fail(function(jqXHR, textStatus, errorThrown) {
    artist_field.addClass('is-invalid');
    title_field.addClass('is-invalid');
    jQuery('#add_sources_error').text('Bad data. Fix pls :(');
  });
}

function remove_source_click(event) {
  let list_item = jQuery(event.target).closest('li');
  let artist = list_item.find('.artist').text().trim();
  let title = list_item.find('.title').text().trim();

  re = jQuery.ajax({
    'data': {
      'sources': {
        'type': 'remove',
        'artist': artist,
        'title': title
      }
    },
    'method': 'PUT',
    'url': `${window.location.pathname}/sources`
  }).done(function(data, textStatus, jqXHR) {
    update_list(data);
  });
}

jQuery(function() {
  jQuery('#add_sources_button').click(add_source_click);
  jQuery('.remove_sources_button').click(remove_source_click);
});

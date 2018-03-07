class DisplayCsvFileName {
  constructor() {
    $(document).on('change', ':file', this.constructor.display)
  }

  static display() {
    const label = $(this).val().replace(/\\/g, '/').replace(/.*\//, '')
    $('#csv-import-filename').text(label)
  }
}

export default DisplayCsvFileName

class DisplayCsvFileName {
  constructor() {
    $(document).on('change', ':file', this.constructor.display)
  }

  static display() {
    const $input = $(this)
    const label = $input.val().replace(/\\/g, '/').replace(/.*\//, '')
    $input.parent().parent().next(':text').val(label)
  }
}

export default DisplayCsvFileName

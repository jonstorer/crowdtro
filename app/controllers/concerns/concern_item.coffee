Concern = require 'models/concern'

ConcernShow = require 'controllers/concerns/concern_show'
ConcernEdit = require 'controllers/concerns/concern_edit'

class ConcernList extends Spine.Stack
  className: 'row-fluid'

  controllers:
    show: ConcernShow
    edit: ConcernEdit

  routes:
    'show':  'show'
    'edit':  'edit'

  default: 'show'

module.exports = ConcernList

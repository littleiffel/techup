package lu.techup

class User {

	transient springSecurityService

	String username
	String password
	boolean enabled
	boolean accountExpired
	boolean accountLocked
	boolean passwordExpired

	String toString() {
      return username
   }


	static constraints = {
		username blank: false, unique: true
		password blank: false
	}

	static hasMany = [created:Event, attends:Event]

	static mappedBy = [created:'initiator', attends:'attendees']

	static mapping = {
		table 'appuser'
		password column: '`password`'
	}

	Set<Role> getAuthorities() {
		UserRole.findAllByUser(this).collect { it.role } as Set
	}

	def beforeInsert() {
		encodePassword()
	}

	def beforeUpdate() {
		if (isDirty('password')) {
			encodePassword()
		}
	}

	protected void encodePassword() {
		password = springSecurityService.encodePassword(password)
	}
}

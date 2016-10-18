module Msf

	class Plugin::Minion < Msf::Plugin

		def initialize(framework, opts)
			super
			add_console_dispatcher(MinionCommandDispatcher)
		end

		def cleanup
			self.framework.events.remove_session_subscriber(self)
			remove_console_dispatcher("Minion")
		end

		def name
			"Minion"
		end

		def desc
			"Automate stuff in the MSF database. Why burn time when a minion could do it?"
		end

		class MinionCommandDispatcher
			include Msf::Ui::Console::CommandDispatcher

			def commands
				{
					'mssql_attack' => "Try common users and passwords on MSSQL services"
				}
			end

			def name
				"Minion"
			end

			def cmd_mssql_attack
        			self.shell.run_single("use auxiliary/scanner/mssql/mssql_login")
        			self.shell.run_single("set PASS_FILE /wordlists/mssql_pwds.txt")
        			self.shell.run_single("set BLANK_PASSWORDS true")
				#put any other code here for this function
      			end
		end
	end
end

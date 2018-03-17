function Set-TlsLevel {
    [CmdletBinding( SupportsShouldProcess = $false )]
    [System.Diagnostics.CodeAnalysis.SuppressMessage('PSUseShouldProcessForStateChangingFunctions', '')]
    param (
        [Parameter(Mandatory, ParameterSetName = 'Set')]
        [Switch]$Tls12,

        [Parameter(Mandatory, ParameterSetName = 'Revert')]
        [Switch]$Revert
    )

    begin {
        switch ($PSCmdlet.ParameterSetName) {
            "Set" {
                $Script:OriginalTlsSettings = [Net.ServicePointManager]::SecurityProtocol

                [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.ServicePointManager]::Tls12
            }
            "Revert" {
                [Net.ServicePointManager]::SecurityProtocol = $Script:OriginalTlsSettings
            }
        }
    }
}

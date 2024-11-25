<?php

namespace App\Entity;

use Doctrine\DBAL\Connection;

class ReleveNotes
{
    public function getAllReleveNotes(Connection $connection): array
    {
        $sql = 'SELECT * FROM v_releve_notes';
        
        $stmt = $connection->executeQuery($sql);

        return $stmt->fetchAllAssociative();
    }
}
